require 'rails_helper'

RSpec.describe "Projects", type: :request do
    let(:valid_attributes) {
        {
          title: 'A project Title',
          description: 'It is an project content.',
          creator_id: 1,
        }
      }
    
      let(:invalid_attributes) {
        {
            title: nil,
            description: nil,
            creator_id: nil
          }
      }
      describe "GET /index" do
        it "renders a successful response" do
          Project.create! valid_attributes
          get projects_url
          expect(response).to be_successful
        end
      end
      describe "GET /show" do
        it "renders a successful response" do
          project = Project.create! valid_attributes
          get project_url(project)
          expect(response).to be_successful
        end
      end
    
      describe "GET /new" do
        it "renders a successful response" do
            project = Project.create! valid_attributes
          get new_project_url
          expect(response).to be_successful
        end
      end
    
      describe "GET /edit" do
        it "render a successful response" do
          project = Project.create! valid_attributes
          get edit_project_url(project)
          expect(response).to be_successful
        end
      end

      describe "POST /create" do
        context "with valid parameters" do
          it "creates a new project" do
            expect {
              post projects_url, params: { project: valid_attributes }
            }.to change(Project, :count).by(1)

            expect(project.title).to eq('A Article Title')
            expect(project.description).to eq('It is an article description.')
          end
        
          it "redirects to the created project" do
            post projects_url, params: { project: valid_attributes }
            expect(response).to redirect_to(project_url(Project.last))
          end
        end
    
        context "with invalid parameters" do
          it "does not create a new project" do
            expect {
              post projects_url, params: { project: invalid_attributes }
            }.to change(Project, :count).by(0)
          end
    
          it "renders a successful response (i.e. to display the 'new' template)" do
            post projects_url, params: { project: invalid_attributes }
            expect(response).to be_successful
          end
        end
      end


      describe "PATCH /update" do
        context "with valid parameters" do
          let(:new_attributes) {
            skip("Add a hash of attributes valid for your model")
          }
    
          it "updates the requested project" do
            project = Project.create! valid_attributes
            patch project_url(project), params: { project: new_attributes }
            project.reload
            skip("Add assertions for updated state")
          end
    
          it "redirects to the project" do
            project = Project.create! valid_attributes
            patch project_url(project), params: { project: new_attributes }
            project.reload
            expect(response).to redirect_to(project_url(project))
          end
        end
    
        context "with invalid parameters" do
          it "renders a successful response (i.e. to display the 'edit' template)" do
            project = Project.create! valid_attributes
            patch project_url(project), params: { project: new_attributes }
            expect(response).to be_successful
          end
        end
        describe "DELETE /destroy" do
            it "destroys the requested project" do
              project = Project.create! valid_attributes
              expect {
                delete project_url(project)
              }.to change(Project, :count).by(-1)
            end
        
            it "redirects to the projects list" do
                project = Project.create! valid_attributes
              delete project_url(project)
              expect(response).to redirect_to(projects_url)
            end
          end
      end
end
