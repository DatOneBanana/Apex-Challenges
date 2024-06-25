import { LightningElement, track } from 'lwc';
import getAccounts from '@salesforce/apex/SearchAccount.getAccounts';

export default class ImperativeInpnutAccount extends LightningElement {
    @track searchKey = '';
    @track accounts;
    @track error;

    handleInputChange(event) {
        this.searchKey = event.target.value;
        this.searchAccounts();
    }

    async searchAccounts() {
        try{
            this.accounts = await getAccounts({ searchKey: this.searchKey });
            this.error = undefined;
        }
        catch{
            this.error = error;
            this.contacts = undefined;
        }
    }
}