App.NoteView = Em.View.extend
  classNames: 'note'
  templateName: 'note'

  displayNote: ->
    $('.note').addClass 'active'
    editor = new EpicEditor(
      theme:
        base: '/base.css'
        preview: '/preview.css'
        editor: '/editor.css'
      file:
        defaultContent: "#Deja Vu\n---\nhmm, I've been on this corner before.."
      button:
        fullscreen: false
    ).load()

  didInsertElement: ->
    @displayNote()
