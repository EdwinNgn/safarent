import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  new Typed('#banner-typed-text', {
    strings: ["a Lion ? ", "a Jaguar ?", "a Pingoo ?", "a Kangaroo ?", "an Elephant ?", "or a Pigeon...."],
    typeSpeed: 100,
    loop: true
  });
}

export { loadDynamicBannerText };
