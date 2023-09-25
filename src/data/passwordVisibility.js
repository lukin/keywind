const toggle = (button) =>  {
  const passwordElement = document.getElementById(button.getAttribute('aria-controls'));
  if (passwordElement.type === "password") {
      passwordElement.type = "text";
      button.children.item(0).style.display = "none";
      button.children.item(1).style.display = "block";
      button.setAttribute("aria-label", button.dataset.labelHide);
  } else if(passwordElement.type === "text") {
      passwordElement.type = "password";
      button.children.item(0).style.display = "block";
      button.children.item(1).style.display = "none";
      button.setAttribute("aria-label", button.dataset.labelShow);
  }
}

document.querySelectorAll('[data-password-toggle]')
  .forEach(button => button.onclick = () => toggle(button));
