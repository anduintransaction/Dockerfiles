#!/usr/bin/env bash
################################################################################
#  Licensed to the Apache Software Foundation (ASF) under one
#  or more contributor license agreements.  See the NOTICE file
#  distributed with this work for additional information
#  regarding copyright ownership.  The ASF licenses this file
#  to you under the Apache License, Version 2.0 (the
#  "License"); you may not use this file except in compliance
#  with the License.  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
# limitations under the License.
################################################################################

bin=`dirname "$0"`
bin=`cd "$bin"; pwd`

. "$bin"/config.sh

CLASS_TO_RUN=org.apache.flink.runtime.webmonitor.history.HistoryServer

FLINK_TM_CLASSPATH=`constructFlinkClassPath`

log_setting=("-Dlog4j.configuration=file:${FLINK_CONF_DIR}/log4j-console.properties" "-Dlogback.configurationFile=file:${FLINK_CONF_DIR}/logback-console.xml")

JAVA_VERSION=$(${JAVA_RUN} -version 2>&1 | sed 's/.*version "\(.*\)\.\(.*\)\..*"/\1\2/; 1q')

# Only set JVM 8 arguments if we have correctly extracted the version
if [[ ${JAVA_VERSION} =~ ${IS_NUMBER} ]]; then
    if [ "$JAVA_VERSION" -lt 18 ]; then
        JVM_ARGS="$JVM_ARGS -XX:MaxPermSize=256m"
    fi
fi

exec $JAVA_RUN $JVM_ARGS ${FLINK_ENV_JAVA_OPTS} "${log_setting[@]}" -classpath "`manglePathList "$FLINK_TM_CLASSPATH:$INTERNAL_HADOOP_CLASSPATHS"`" ${CLASS_TO_RUN} "--configDir" "${FLINK_CONF_DIR}" $@
