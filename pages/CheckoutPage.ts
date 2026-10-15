import { Page, expect } from '@playwright/test';
import { BasePage } from './BasePage';

export class CheckoutPage extends BasePage {
  constructor(page: Page) {
    super(page);
  }

  get firstNameInput()  { return this.page.getByPlaceholder('First Name'); }
  get lastNameInput()   { return this.page.getByPlaceholder('Last Name'); }
  get postalCodeInput() { return this.page.getByPlaceholder('Zip/Postal Code'); }
  get continueButton()  { return this.page.getByRole('button', { name: 'Continue' }); }
  get finishButton()    { return this.page.getByRole('button', { name: 'Finish' }); }
  get confirmationMsg() { return this.page.getByText('Thank you for your order!'); }
  get summaryProductName() { return this.page.locator('[data-test="inventory-item-name"]'); }
  get summaryTotal() { return this.page.locator('[data-test="total-label"]'); }

  async fillCustomerData(firstName: string, lastName: string, postalCode: string) {
    await this.firstNameInput.fill(firstName);
    await this.lastNameInput.fill(lastName);
    await this.postalCodeInput.fill(postalCode);
    await this.continueButton.click();
  }

  // deja los campos vacios a proposito para disparar la validacion de campos obligatorios
  async continueWithoutData() {
    await this.continueButton.click();
  }

  async finishPurchase() {
    await this.finishButton.click();
  }

  async expectOrderSummary(productName: string, total: string) {
    await this.expectURL(/checkout-step-two/);
    await expect(this.page.getByText('Checkout: Overview')).toBeVisible();
    await expect(this.summaryProductName).toHaveText(productName);
    await expect(this.summaryTotal).toHaveText(`Total: ${total}`);
  }

  async expectOrderComplete() {
    await expect(this.confirmationMsg).toBeVisible();
  }
}
