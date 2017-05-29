class NotesController < ApplicationController
    
    def index
        notes = Note.order(id: :asc)

        render json: notes.as_json(include: :tags)
    end

    def show
        note = Note.find(params[:id])
        render json: note.as_json(include: :tags)
    end

    def create
        note = Note.create(note_params)

        if note.valid?
            render json: note, status: :created
        else
            render json: render_errors(note), status: :unprocessable_entity 
        end
    end

    def update
        note = Note.find(params[:id])
        if note.update_attributes(note_params)
            render json: note, status: :ok
        else
            render json: render_errors(note), status: :unprocessable_entity
        end
    end

    def destroy
        note = Note.find(params[:id])
        note.destroy

        head :no_content
    end

    private

    def note_params
        params.require(:note).permit(:title, :content)
    end

    def render_errors(note)
        { errors: note.errors}
    end
end
