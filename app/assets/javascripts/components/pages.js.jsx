var Pages = React.createClass({
    getInitialState: function() {
        return { pages: this.props.data };
    },

    getDefaultProps: function() {
        return { pages: [] };
    },

    addPage: function(page) {
        var pages = this.state.pages.slice();
        pages.push(page);
        this.setState({ pages: pages});
    },

    render: function() {
        return(
            <div className="">
                <h2 className="title">
                    Pages
                </h2>
                <div className="col-md-5">
                    <table className="table table-bordered">
                        <thead>
                        <tr>
                            <th>Title</th>
                        </tr>
                        </thead>
                        <tbody>
                        {this.state.pages.map(function(page) {
                            return <Page key={page.id} page={page} />
                        })}
                        </tbody>
                    </table>
                </div>

                <div className="col-md-offset-5 col-md-8">
                    <PageForm handleNewPage={this.addPage} />
                </div>

            </div>
        )
    }
})