const startDate = document.getElementById('range_start')

if (startDate) {
  startDate.addEventListener('change', (event) => {
    const startDate = document.getElementById('range_start')
    const endDate = document.getElementById('range_end');
    const start = new Date(startDate.value);
    const end = new Date(endDate.value);
    const diffDays = (end - start) / (1000 * 60 * 60 * 24);
    const price = document.getElementById('price');
    const priceString= price.innerText;
    const priceInt = parseFloat(priceString);
    const total = priceString * diffDays;
    const totalPrice = document.querySelector('.total-price')
    console.log(total)
    totalPrice.innerText = total + "€"
    if (isNaN(total)) {
      console.log('hello')
      totalPrice.innerText = "0€"
    }

  })
}
