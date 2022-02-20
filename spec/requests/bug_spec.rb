require 'rails_helper'

RSpec.describe "bugs", type: :request do
    let(:valid_attributes) {
        {
          title: 'A bug Title',
          description: 'It is an bug content.',
          bugtype:0,
          created_by: 2
        }
      }
    
      let(:invalid_attributes) {
        {
            title: nil,
            description: nil,
        }
      }
      describe "GET /index" do
        it "renders a successful response" do
          Bug.create! valid_attributes
          get project_bugs_url
          expect(response).to be_successful
        end
      end
      describe "GET /show" do
        it "renders a successful response" do
          bug = Bug.create! valid_attributes
          get new_project_bug_url(project)
          expect(response).to be_successful
        end
      end
    
      describe "GET /new" do
        it "renders a successful response" do
            bug = Bug.create! valid_attributes
          get new_project_bug_url
          expect(response).to be_successful
        end
      end
    
      describe "GET /edit" do
        it "render a successful response" do
          bug = Bug.create! valid_attributes
          get edit_project_bug_url(bug)
          expect(response).to be_successful
        end
      end

      describe "POST /create" do
        context "with valid parameters" do
          it "creates a new bug" do
            expect {
              post project_bugs_url, params: { bug: valid_attributes }
            }.to change(bug, :count).by(1)

            expect(bug.title).to eq('A Article Title')
            expect(bug.description).to eq('It is an article description.')
          end
        
          it "redirects to the created project" do
            post project_bugs_url, params: { bug: valid_attributes }
            expect(response).to redirect_to(project_bug_url(Bug.last))
          end
        end
    
        context "with invalid parameters" do
          it "does not create a new project" do
            expect {
              post project_bugs_url, params: { bug: invalid_attributes }
            }.to change(Bug, :count).by(0)
          end
    
          it "renders a successful response (i.e. to display the 'new' template)" do
            post project_bug_url, params: { bug: invalid_attributes }
            expect(response).to be_successful
          end
        end
      end


      describe "PATCH /update" do
        context "with valid parameters" do
          let(:new_attributes) {
            {
                title: 'A bug Title',
                description: 'It is an bug content.',
                bugtype:0,
                created_by: 2
            }
          }
    
          it "updates the requested bug" do
            bug = Bug.create! valid_attributes
            patch project_bugs_url(bug), params: { bug: new_attributes }
            bug.reload
            
          end
    
          it "redirects to the bug" do
            bug = Bug.create! valid_attributes
            patch project_bug_url(bug), params: { bug: new_attributes }
            bug.reload
            expect(response).to redirect_to(project_bugs_url(bug))
          end
        end
    
        context "with invalid parameters" do
          it "renders a successful response (i.e. to display the 'edit' template)" do
            bug = Bug.create! valid_attributes
            patch project_bugs_url(bug), params: { bug: new_attributes }
            expect(response).to be_successful
          end
        end
        describe "DELETE /destroy" do
            it "destroys the requested bug" do
              bug = Bug.create! valid_attributes
              expect {
                delete project_bug_url(bug)
              }.to change(bug, :count).by(-1)
            end
        
            it "redirects to the bugs list" do
              bug = Bug.create! valid_attributes
              delete project_bug_url(bug)
              expect(response).to redirect_to(project_bugs_url)
            end
          end
      end
end
