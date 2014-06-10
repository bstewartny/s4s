#!/bin/bash

# https://gist.github.com/949831
# http://blog.carbonfive.com/2011/05/04/automated-ad-hoc-builds-using-xcode-4/

# command line OTA distribution references and examples
# http://nachbaur.com/blog/how-to-automate-your-iphone-app-builds-with-hudson
# http://nachbaur.com/blog/building-ios-apps-for-over-the-air-adhoc-distribution
# http://blog.octo.com/en/automating-over-the-air-deployment-for-iphone/
# http://www.neat.io/posts/2010/10/27/automated-ota-ios-app-distribution.html

project_dir=`pwd`

deploy_dir="/Users/bstewart/Dropbox/stars4stripes/s4s/deploy"
# Configuration
environment_name="dev"
keychain="login"
keychain_password="Frodo2013"
appname="StarsOnStripes"
deployname="StarsOnStripes"
scheme="StarsOnStripes"
info_plist="$project_dir/StarsOnStripes/StarsOnStripes-Info.plist"
mobileprovision="$deploy_dir/StarsOnStripes_Distribution_Profile.mobileprovision"
provisioning_profile="iPhone Distribution: robert stewart"
build_number="1"
artifacts_url="http://kasistodemo.appspot.com/app"
display_image_name="Icon.png"
full_size_image_name="Icon-512.png"
bundle_identifier="com.starsonstripes.StarsOnStripes"

function cleanup()
{
    rm -R "$project_dir/xcodebuild_output"
    rm -R "$project_dir/$deployname.ipa"
    rm -R "$project_dir/$deployname.plist"
    rm -R "$project_dir/$appname.app"
    rm -R "$project_dir/$appname.app.dSYM"
}

function failed()
{
    local error=${1:-Undefined error}
    echo "Failed: $error" >&2
    exit 1
}

function validate_keychain()
{
  # unlock the keychain containing the provisioning profile's private key and set it as the default keychain
  security unlock-keychain -p "$keychain_password" "$HOME/Library/Keychains/$keychain.keychain"
  security default-keychain -s "$HOME/Library/Keychains/$keychain.keychain"
  
  #describe the available provisioning profiles
  echo "Available provisioning profiles"
  security find-identity -p codesigning -v

  #verify that the requested provisioning profile can be found
  (security find-certificate -a -c "$provisioning_profile" -Z | grep ^SHA-1) || failed provisioning_profile  
}

function describe_sdks()
{
  #list the installed sdks
  echo "Available SDKs"
  xcodebuild -showsdks  
}

function increment_version()
{
  agvtool -noscm next-version -all 
  build_number=`agvtool what-version -terse`
}


function build_app()
{
  local devired_data_path="$HOME/Library/Developer/Xcode/DerivedData"
  echo "Running xcodebuild > xcodebuild_output ..."

  xcodebuild -verbose -scheme "$scheme" -sdk iphoneos -configuration Release clean build >| xcodebuild_output

  if [ $? -ne 0 ]
  then
    tail -n20 xcodebuild_output
    failed xcodebuild
  fi
  
  #locate this project's DerivedData directory
  local project_derived_data_directory=$(grep -oE "StarsOnStripes-([a-zA-Z0-9]+)[/]" xcodebuild_output | sed -n "s/\(StarsOnStripes-[a-z]\{1,\}\)\//\1/p" | head -n1)
  local project_derived_data_path="$devired_data_path/$project_derived_data_directory"
  #locate the .app file

  project_app=$(ls -1 "$project_derived_data_path/Build/Products/Release-iphoneos/" | grep "$appname\.app$" | head -n1)
  
  if [ $(ls -1 "$project_derived_data_path/Build/Products/Release-iphoneos/" | grep "$appname\.app$" | wc -l) -ne 1 ]
  then
    echo "Failed to find a single .app build product."
    failed locate_built_product
  fi
  echo "Built $project_app in $project_derived_data_path"

  #copy app and dSYM files to the working directory
  cp -Rf "$project_derived_data_path/Build/Products/Release-iphoneos/$project_app" $project_dir
  cp -Rf "$project_derived_data_path/Build/Products/Release-iphoneos/$project_app.dSYM" $project_dir
  
  #relink CodeResources, xcodebuild does not reliably construct the appropriate symlink
  rm "$project_app/CodeResources"
  ln -s "$project_app/_CodeSignature/CodeResources" "$project_app/CodeResources"
}

function sign_app()
{
  echo "Codesign $project_dir/$project_app as \"$provisioning_profile\", embedding provisioning profile $mobileprovision"
  #sign build for distribution and package as a .ipa
  xcrun -sdk iphoneos PackageApplication "$project_dir/$project_app" -o "$project_dir/$deployname.ipa" --sign "$provisioning_profile" --embed "$mobileprovision" || failed codesign  
}

function deploy_app()
{
    echo "Deploy app to $deploy_dir"
    cp "$project_dir/$deployname.ipa" "$deploy_dir/$deployname.ipa"
    cp "$project_dir/$deployname.plist" "$deploy_dir/$deployname.plist"
}

function verify_app()
{
  #verify the resulting app
  codesign -d -vvv --file-list - "$project_dir/$project_app" || failed verification  
}

function build_ota_plist()
{
  echo "Generating $project_app.plist"
  cat << EOF > $deployname.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>items</key>
  <array>
    <dict>
      <key>assets</key>
      <array>
        <dict>
          <key>kind</key>
          <string>software-package</string>
          <key>url</key>
          <string>$artifacts_url/$deployname.ipa</string>
        </dict>
      </array>
      <key>metadata</key>
      <dict>
        <key>bundle-identifier</key>
        <string>$bundle_identifier</string>
        <key>bundle-version</key>
        <string>$build_number</string>
        <key>kind</key>
        <string>software</string>
        <key>subtitle</key>
        <string>$environment_name</string>
        <key>title</key>
        <string>$deployname</string>
      </dict>
    </dict>
  </array>
</dict>
</plist>
EOF
}

echo "**** Cleanup previous build"
cleanup
echo
echo "**** Validate Keychain"
validate_keychain
echo
echo "**** Describe SDKs"
describe_sdks
echo
echo "**** Increment Bundle Version"
increment_version
echo
echo "**** Build"
build_app
echo
echo "**** Package Application"
sign_app
echo
echo "**** Verify"
verify_app
echo
echo "**** Prepare OTA Distribution"
build_ota_plist
echo
echo "**** Deploy app"
deploy_app
echo
echo "**** Cleanup build"
cleanup
echo
echo "**** Complete!"
