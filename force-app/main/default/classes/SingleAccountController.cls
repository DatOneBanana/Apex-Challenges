public class SingleAccountController {
    public Account account { get; set; }
    public String aboutMe { get; set; }
    public Boolean showGreeting { get; set; }
    
    // replace with ID
    private static final Id ACCOUNT_ID = '';
    
    public SingleAccountController() {
        showGreeting = false;
        account = [SELECT Id, Name, Phone, Industry, Website FROM Account WHERE Id = :ACCOUNT_ID LIMIT 1];

        String userLanguage = UserInfo.getLanguage();
        if (userLanguage == 'es') {
            aboutMe = 'Sobre mí: Soy un desarrollador de Salesforce con amplia experiencia en la creación de soluciones eficientes y efectivas para problemas complejos.';
        } else {
            aboutMe = 'About Me: I am a Salesforce developer with extensive experience in creating efficient and effective solutions for complex problems.';
        }
    }

    public void showGreetingMessage() {
        showGreeting = true;
    }
}