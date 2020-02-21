const divPrice = document.getElementById("price");

if (divPrice) {divPrice.addEventListener("change", (event) => {
  const label = event.target.labels[0]
  label.innerText = `Less than : ${event.target.value}$`
});
}
