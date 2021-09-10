if test -n "$(find ${filepath} -maxdepth 15 -name '*.java' -print -quit)"
then
    echo found
    SONAR_JAVA_OPTS="-Dsonar.java.binaries=${filepath}/build/classes/java/main \
                   -Dsonar.java.test.binaries${filepath}/build/classes/java/test \
                   -Dsonar.java.source=11"
    echo ${SONAR_JAVA_OPTS}
else
    echo not found
fi

