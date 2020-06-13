// import { Controller } from "stimulus"

addEventListener("direct-upload:initialize", event => {
  const { target, detail } = event
  const { id, file } = detail
  target.insertAdjacentHTML("beforebegin", `
    <div id="direct-upload-${id}" class="direct-upload direct-upload--pending">
      <div id="direct-upload-progress-${id}" class="direct-upload__progress" style="width: 0%"></div>
      <span class="direct-upload__filename"></span>
    </div>
  `)
  target.previousElementSibling.querySelector(`.direct-upload__filename`).textContent = file.name
})

addEventListener("direct-upload:start", event => {
  const { id } = event.detail
  const element = document.getElementById(`direct-upload-${id}`)
  element.classList.remove("direct-upload--pending")
})

addEventListener("direct-upload:progress", event => {
  const { id, progress } = event.detail
  const progressElement = document.getElementById(`direct-upload-progress-${id}`)
  progressElement.style.width = `${progress}%`
})

addEventListener("direct-upload:error", event => {
  event.preventDefault()
  const { id, error } = event.detail
  const element = document.getElementById(`direct-upload-${id}`)
  element.classList.add("direct-upload--error")
  element.setAttribute("title", error)
})

addEventListener("direct-upload:end", event => {
  const { id } = event.detail
  const element = document.getElementById(`direct-upload-${id}`)
  element.classList.add("direct-upload--complete")
})

// import { DirectUpload } from "@rails/activestorage"

// class Uploader {
//   constructor(input, file) {
//     this.input = input;
//     this.file = file;
//     this.url = input.dataset.directUploadUrl;
//     this.upload = new DirectUpload(this.file, this.url, this)
//     this.upload.create((error, blob) => {
//       if (error) {
//         const element = document.getElementById(`direct-upload`)
//         element.classList.add("direct-upload--error")
//         element.setAttribute("title", error)
//       } else {
//         const hiddenField = document.createElement('input')
//         hiddenField.setAttribute("type", "hidden");
//         hiddenField.setAttribute("value", blob.signed_id);
//         hiddenField.name = input.name
//         document.querySelector('form').appendChild(hiddenField)  

//         const element = document.getElementById(`direct-upload`)
//         element.classList.add("direct-upload--complete")
//       }
//     })
//     input.insertAdjacentHTML("beforebegin", `
//       <div id="direct-upload" class="direct-upload">
//         <div id="direct-upload-progress" class="direct-upload__progress" style="width: 0%"></div>
//         <span class="direct-upload__filename"></span>
//       </div>
//     `)
//     input.previousElementSibling.querySelector(`.direct-upload__filename`).textContent = file.name
//   }

//   directUploadWillStoreFileWithXHR(request) {
//     request.upload.addEventListener("progress",
//       event => this.directUploadDidProgress(event))
//   }

//   directUploadDidProgress(event) {
//     const progress = 100 * event.loaded / event.total;
//     const progressElement = document.getElementById(`direct-upload-progress`)
//     progressElement.style.width = `${progress}%`
//   }
// }

// export default class RegistrationController extends Controller {
//   uploadLogo(e) {
//     const input = e.target;
//     Array.from(input.files).forEach(file => new Uploader(input, file))
//     input.value = null
//   }
// }
