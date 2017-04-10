# ************************************************************
#
# This step will enable/disable cache
#
#   Variables used:
#     $FLOW_ENABLE_CACHE
#     $FLOW_VERSION
#
#   Outputs:
#     $FLOW_ENABLE_CACHE
#
# ************************************************************

cache_gradle(){
  echo 'start gradle cache'
  FLOW_GRADLE_CACHE_PATH="$CACHE_BASE_URL/gradle/user_cache"
  FLOW_USER_GRADLE_CACHE="$HOME/.gradle/gradle.properties"
  
  if [[ -d $FLOW_GRADLE_CACHE_PATH ]]; then
     echo "gradle cache exists"
  else
    # echo "cache not exists"
    mkdir -p $FLOW_GRADLE_CACHE_PATH
  fi
  echo "$(date)" > $FLOW_GRADLE_CACHE_PATH/cache_version
  cp -f $FLOW_USER_GRADLE_CACHE/gradle.properties $FLOW_GRADLE_CACHE_PATH/
  rm -rf  $FLOW_USER_GRADLE_CACHE && ln -s  $FLOW_GRADLE_CACHE_PATH $FLOW_USER_GRADLE_CACHE

 FLOW_PROJECT_CACHE_PATH="$CACHE_BASE_URL/gradle/project_cache"
 FLOW_PROJECT_GRADLE_CACHE="$FLOW_CURRENT_PROJECT_PATH/.gradle/gradle.properties"

  if [[ -d $FLOW_PROJECT_CACHE_PATH ]]; then
     echo "gradle cache exists"
  else
    mkdir -p $FLOW_PROJECT_CACHE_PATH
  fi
  echo "$(date)" > $FLOW_PROJECT_CACHE_PATH/cache_version
  rm -rf  $FLOW_PROJECT_GRADLE_CACHE && ln -s $FLOW_PROJECT_CACHE_PATH $FLOW_PROJECT_GRADLE_CACHE
}


mvn_cache(){
  echo 'start maven cache'
  # MAVEN
  FLOW_MAVEN_CACHE_PATH="$CACHE_BASE_URL/maven/user_cache"
  FLOW_USER_MAVEN_CACHE="$HOME/.m2"
  if [[ -d $FLOW_MAVEN_CACHE_PATH ]]; then
    echo "gradle cache exists"
  else
    #echo "cache not exists"
    mkdir -p $FLOW_MAVEN_CACHE_PATH
  fi
  echo "$(date)" > $FLOW_MAVEN_CACHE_PATH/cache_version
  rm -rf  $FLOW_USER_MAVEN_CACHE && ln -s  $FLOW_MAVEN_CACHE_PATH $FLOW_USER_MAVEN_CACHE
}
#
if [[ $FLOW_ENABLE_CACHE == 'TRUE' ]]; then
  #默认采用maven缓存，如果用户选择了gradle，则采用gradle缓存
  if [[ $ENABLE_GRADLE_CACHE == 'TRUE' ]]; then
    cache_gradle
  fi
  if [[ $ENABLE_MAVEN_CACHE == 'TRUE' ]]; then
    mvn_cache
  fi
else
  echo 'cache disabled'
fi
