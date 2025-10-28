package org.udea.parabank;

import com.intuit.karate.junit5.Karate;

class TestRunner {

    @Karate.Test
    Karate test01_ParabankLogin() {
        return Karate.run("login")
                .relativeTo(getClass())
                .outputCucumberJson(true);
    }

    @Karate.Test
    Karate test02_ParabankAccounts() {
        return Karate.run("accounts")
                .relativeTo(getClass())
                .outputCucumberJson(true);
    }

    /*@Karate.Test
    Karate test03_ParabankTransfers() {
        return Karate.run("transfer")
                .relativeTo(getClass())
                .outputCucumberJson(true);
    }*/

    @Karate.Test
    Karate test04_ParabankAccounts() {
        return Karate.run("loan")
                .relativeTo(getClass())
                .outputCucumberJson(true);
    }

}


