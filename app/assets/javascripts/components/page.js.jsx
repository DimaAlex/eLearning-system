var Page = React.createClass({
    renderIcon: function() {
        if ( this.props.page.page_type == "lecture" ) {
            return  <i className="glyphicon glyphicon-file"></i>
        } else if(this.props.page.page_type == "video"){
            return  <i className="glyphicon glyphicon-film"></i>
        } else {
            return  <i className="glyphicon glyphicon-question-sign"></i>
        }
    },

    render: function() {
        return(
            <div className="list-group-item">
                {this.props.page.title}
                <span style={{float: "right"}}>
                     {this.renderIcon()}
                </span>

            </div>
        )
    }
})