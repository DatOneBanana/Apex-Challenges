import { LightningElement, track } from 'lwc';
import createContact from '@salesforce/apex/ContactController.createContact';

export default class ContactCreateForm extends LightningElement {
    @track firstName = '';
    @track lastName = '';
    @track email = '';
    @track phone = '';
    @track accountId = '';

    handleInputChange(event) {
        const field = event.target.dataset.id;
        if (field === 'firstName') {
            this.firstName = event.target.value;
        } else if (field === 'lastName') {
            this.lastName = event.target.value;
        } else if (field === 'email') {
            this.email = event.target.value;
        } else if (field === 'phone') {
            this.phone = event.target.value;
        } else if (field === 'accountId') {
            this.accountId = event.target.value;
        }
    }

    createContact() {
        const contact = {
            FirstName: this.firstName,
            LastName: this.lastName,
            Email: this.email,
            Phone: this.phone,
            AccountId: this.accountId
        };

        createContact({ contact })
            .then(() => {
                this.clearForm();
            })
            .catch(error => {
                console.error('Error creating contact:', error);
            });
    }

        clearForm() {
        this.firstName = '';
        this.lastName = '';
        this.email = '';
        this.phone = '';
        this.accountId = '';
    }
}