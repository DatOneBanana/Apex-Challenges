import { createElement } from 'lwc';
import ContactForm from 'c/contactForm';
import createContact from '@salesforce/apex/ContactController.createContact';

jest.mock('@salesforce/apex/ContactController.createContact', () => {
    return {
        default: jest.fn()
    };
}, { virtual: true });

describe('c-contact-form', () => {
    afterEach(() => {
        // The jsdom instance is shared across test cases in a single file so reset the DOM
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
        
        jest.clearAllMocks();
    });

    it('renders input fields and button', () => {
        const element = createElement('c-contact-form', {
            is: ContactForm
        });
        document.body.appendChild(element);

        // Query lightning-input fields
        const inputs = element.shadowRoot.querySelectorAll('lightning-input');
        expect(inputs.length).toBe(5);
        expect(inputs[0].label).toBe('First Name');
        expect(inputs[1].label).toBe('Last Name');
        expect(inputs[2].label).toBe('Email');
        expect(inputs[3].label).toBe('Phone');
        expect(inputs[4].label).toBe('Account ID');

        // Query lightning-button
        const button = element.shadowRoot.querySelector('lightning-button');
        expect(button.label).toBe('Create Contact');
    });

    it('handles input changes correctly', () => {
        const element = createElement('c-contact-form', {
            is: ContactForm
        });
        document.body.appendChild(element);

        const inputFields = element.shadowRoot.querySelectorAll('lightning-input');
        inputFields.forEach(input => {
            input.value = 'test value';
            input.dispatchEvent(new CustomEvent('change'));
        });

        expect(element.firstName).toBe('test value');
        expect(element.lastName).toBe('test value');
        expect(element.email).toBe('test value');
        expect(element.phone).toBe('test value');
        expect(element.accountId).toBe('test value');
    });

    it('calls method on button click', async () => {
        const element = createElement('c-contact-form', {
            is: ContactForm
        });
        document.body.appendChild(element);

        const inputFields = element.shadowRoot.querySelectorAll('lightning-input');
        inputFields.forEach(input => {
            input.value = 'test value';
            input.dispatchEvent(new CustomEvent('change'));
        });

        const button = element.shadowRoot.querySelector('lightning-button');
        button.click();

        // Wait for any asynchronous DOM updates
        await Promise.resolve();

        expect(createContact).toHaveBeenCalledTimes(1);
        expect(createContact).toHaveBeenCalledWith({
            contact: {
                FirstName: 'test value',
                LastName: 'test value',
                Email: 'test value',
                Phone: 'test value',
                AccountId: 'test value'
            }
        });
    });

    it('logs an error if method fails', async () => {
        const consoleErrorSpy = jest.spyOn(console, 'error');
        createContact.mockRejectedValue(new Error('test error'));

        const element = createElement('c-contact-form', {
            is: ContactForm
        });
        document.body.appendChild(element);

        const button = element.shadowRoot.querySelector('lightning-button');
        button.click();

        // Wait for any asynchronous DOM updates
        await Promise.resolve();

        expect(consoleErrorSpy).toHaveBeenCalledWith('Error creating contact:', new Error('test error'));
    });
});
