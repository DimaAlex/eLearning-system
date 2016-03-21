var Course = React.createClass({
    render: function() {
        return(
            <tr>
                <td>{this.props.course.id}</td>
                <td>{this.props.course.title}</td>
                <td>{this.props.course.permission}</td>
            </tr>
        )
    }
})