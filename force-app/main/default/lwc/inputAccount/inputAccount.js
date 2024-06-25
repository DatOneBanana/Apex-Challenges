import { LightningElement, wire, track } from 'lwc';
import getAccounts from '@salesforce/apex/SearchAccount.getAccounts';

export default class InputAccount extends LightningElement {
    @track searchKey = '';
    @track accounts;

    @wire(getAccounts, { searchKey: '$searchKey' })
    wiredAccounts(result) {
        this.accounts = result;
    }

    handleInputChange(event) {
        this.searchKey = event.target.value;
    }
}