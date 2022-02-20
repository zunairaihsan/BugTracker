// https://material.io/design/components/cards.html#behavior
// https://codepen.io/choogoor/full/YWBxAg/

const card_info = document.querySelector('.card__info');
const like_button = document.querySelector('button.fa-heart');

const toggle_info = () => {
    if (card_info.classList.contains('show')) {
        card_info.classList.remove('show');
    } else {
        card_info.classList.add('show');
    }
};

const like_clicked = () => {
  const likes = like_button.querySelector('span');
  if (like_button.classList.contains('liked')) {
    like_button.classList.remove('liked');
    likes.textContent = parseInt(likes.textContent) - 1;
  } else {
    like_button.classList.add('liked');
    likes.textContent = parseInt(likes.textContent) + 1;
  }
};

card_info.addEventListener('click', toggle_info);
like_button.addEventListener('click', like_clicked);