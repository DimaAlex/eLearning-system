var PageForm = React.createClass({
    componentDidMount: function() {
        $('#editor').froalaEditor();
    },
    componentDidUpdate: function(){
        $('#editor').froalaEditor();
    },
    getInitialState: function() {
        return { title: "",
                 page_type: "lecture"}
    },
    handleChange: function(e) {
        var name = e.target.name;
        var obj = {};
        obj[name] = e.target.value;
        this.setState(obj);
    },
    valid: function() {
        return (this.state.title);
    },

    handleSubmit: function(e) {
        e.preventDefault();
        $.post('',
            { page: this.state },
            function(data) {
                this.props.handleNewPage(data);
                this.setState(this.getInitialState());
            }.bind(this),
            'JSON'
        );
    },

    renderInputForm: function() {
        if ( this.state.page_type == "lecture" ) {
            return <textarea name="body"
                      id="editor"
                      placeholder="Add link from youtube"
                      name="body"
                      value={this.state.body}
                      onChange={this.handleChange}/>

            }
        else if(this.state.page_type == "video"){
            return  <input type="text" className="form-control"
                        placeholder="Add link from youtube" name="body"
                        value={this.state.body} onChange={this.handleChange}>
                    </input>
        } else {
            return  <div>
                        <label>Type of answer</label>
                        <div>
                        </div>
                </div>
        }
    },

    render: function() {
        return(
            <form className="'form-inline" onSubmit={this.handleSubmit}>
                <div className="form-group">
                    <input type="text" className="form-control"
                           placeholder="Title" name="title" maxLength="35"
                           value={this.state.title} onChange={this.handleChange}>
                    </input>
                </div>
                <div className="form-group">
                    { (this.state.page_type == "lecture"
                           ? <input type="radio" name="page_type" value="lecture" onChange={this.handleChange}
                                   checked="checked"/>
                           :  <input type="radio" name="page_type" value="lecture" onChange={this.handleChange}/>
                    )}
                        <span> Lecture</span>
                    <input type="radio"  name="page_type" value="video" onChange={this.handleChange}/>
                        <span> Video</span>
                    <input type="radio"  name="page_type" value="question" onChange={this.handleChange}/>
                        <span> Question</span>
                </div>
                <div>
                    {this.renderInputForm()}
                </div>
                <div className="form-group">
                    <input type="submit" className="btn btn-primary"
                           disabled={!this.valid()}>
                    </input>
                </div>
            </form>
        );
    }
})