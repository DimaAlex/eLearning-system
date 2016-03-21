var CourseForm = React.createClass({
    getInitialState: function() {
        return { title: "",
                 permission: ""}
    },
    handleChange: function(e) {
        var name = e.target.name;
        var obj = {};
        obj[name] = e.target.value;
        this.setState(obj);
    },
    valid: function() {
        return (this.state.title && this.state.permission);
    },

    handleSubmit: function(e) {
        e.preventDefault();
        $.post('',
            { course: this.state },
            function(data) {
                this.props.handleNewCourse(data);
                this.setState(this.getInitialState());
            }.bind(this),
            'JSON'
        );
    },

    render: function() {
        return(
            <form className="'form-inline" onSubmit={this.handleSubmit}>
                <div className="form-group">
                    <input type="text" className="form-control"
                           placeholder="Title" name="title"
                           value={this.state.title} onChange={this.handleChange}>
                    </input>
                </div>
                <div className="form-group">
                    <input type="text" className="form-control"
                           placeholder="Permission" name="permission"
                           value={this.state.permission} onChange={this.handleChange}>
                    </input>
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