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
                <div className="col-md-3">
                    <div className="list-group">
                        <h3 className="list-group-item">
                            Lectures
                        </h3>
                        {this.state.pages.map(function(page) {
                        return <Page key={page.id} page={page} />
                        })}
                    </div>


                </div>
                <div className="col-md-offset-1 col-md-6">
                    <PageForm handleNewPage={this.addPage} />
                </div>

            </div>
        )
    }
})