import { Controller } from 'stimulus';
import StimulusReflex from 'stimulus_reflex';

export default class CommentController extends Controller {
  static targets = [ "text", "postId", "userId" ];

  connect () {
    StimulusReflex.register(this);
  }

  create(event) {
    event.preventDefault();
    const text = this.textTarget.value;
    const postId = this.postIdTarget.value;
    const userId = this.userIdTarget.value;
    this.textTarget.value = '';
    this.textTarget.disabled = true;
    event.target.disabled = true;
    this.stimulate('CommentReflex#create', text, postId, userId);
  }
}
