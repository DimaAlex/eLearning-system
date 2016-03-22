class Header extends React.Component {

  constructor (props){
    super(props);
  }

  userSignedin (valid) {
    if (valid) {
        return (
          <li className="nav-text-color">
            <a href={ this.props.new_user_session_path}>{this.props.current_user.email }</a>
          </li>
      )
    }
    else {
        return (
          <li className="nav-text-color" id="sign_in">
            <a href={this.props.new_user_session_path}>SIGN IN</a>
          </li>
      )
    }
  }

  render () {
    return (
        <nav className="navbar navbar-default navbar-static-top">
          <div className="container">
            <button className="navbar-toggle" type="button" data-toggle="collapse" data-target=".navbar-responsive-collapse">
              <span className="icon-bar"></span>
              <span className="icon-bar"></span>
              <span className="icon-bar"></span>
            </button>
            <a className="navbar-brand" href="#">
              <img alt="Brand" src={this.props.logo}/>
            </a>
            <div className="navbar-collapse collapse navbar-responsive-collapse">
              <ul className="nav navbar-nav">
                <li className="nav-text-color"><a href="">CATEGORIES</a></li>
                <li className="nav-text-color"><a href="">COMPANIES</a></li>
                { this.userSignedin(this.props.user_signed_in) }
              </ul>
            </div>
          </div>
        </nav>
    )
  }
}
