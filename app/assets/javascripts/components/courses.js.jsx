var Courses = React.createClass({
    getInitialState: function() {
        return { courses: this.props.data };
    },

    getDefaultProps: function() {
        return { courses: [] };
    },

    addCourse: function(course) {
        var courses = this.state.courses.slice();
        courses.push(course);
        this.setState({ courses: courses});
    },

    render: function() {
        return(
            <div className="">
                <h2 className="title">
                    Courses
                </h2>
                <CourseForm handleNewCourse={this.addCourse} />
                <table className="table table-bordered">
                    <thead>
                        <tr>
                            <th>Date</th>
                            <th>Title</th>
                            <th>Permission</th>
                        </tr>
                    </thead>
                    <tbody>
                        {this.state.courses.map(function(course) {
                            return <Course key={course.id} course={course} />
                        })}
                    </tbody>
                </table>
            </div>
        )
    }
})