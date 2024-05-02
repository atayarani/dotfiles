{
  segments = {
    os = {
      foreground = "p:os_fg";
      background = "p:os_bg";
      style = "powerline";
      powerline_symbol = "";
      type = "os";
      template = "{{ if .WSL }}WSL at {{ end }} {{.Icon}} ";
    };
    session = {
      background = "p:session_bg";
      foreground = "p:session_fg";
      style = "powerline";
      powerline_symbol = "";
      type = "session";
      properties = {
        template = "{{ .UserName }}";
      };
    };
    git = {
      background = "p:git_bg";
      foreground = "p:git_fg";
      style = "powerline";
      powerline_symbol = "";
      type = "git";
      properties = {
        fetch_status = true;
        template = ":: {{ .HEAD }}{{ .BranchStatus }}{{ if .Staging.Changed }}  {{ .Staging.String }}{{ end }}{{ if and (.Working.Changed) (.Staging.Changed) }} |{{ end }}{{ if .Working.Changed }}  {{ .Working.String }}{{ end }} ";
      };
    };
    aws = {
      type = "aws";
      style = "powerline";
      foreground = "p:aws_fg";
      background = "p:aws_bg";
      powerline_symbol = "";
      properties = {
        template = "   {{.Profile}}{{if .Region}}@{{.Region}}{{end}}";
      };
    };
    node = {
      type = "node";
      foreground = "#6CA35E";
      style = "powerline";
      properties = {
        template = "|  {{ if .PackageManagerIcon }}{{ .PackageManagerIcon }} {{ end }}{{ .Full }} ";
      };
    };
    python = {
      type = "python";
      foreground = "p:python_fg";
      background = "p:python_bg";
      style = "powerline";
      powerline_symbol = "";
      invert_powerline = true;
    };
    battery = {
      type = "battery";
      style = "powerline";
      invert_powerline = true;
      background_templates = [
        "{{if eq \"Charging\" .State.String}}#40c4ff{{end}}"
        "{{if eq \"Discharging\" .State.String}}#ff5722{{end}}"
        "{{if eq \"Full\" .State.String}}#4caf50{{end}}"
      ];
      properties = {
        charged_icon = " ";
        charging_icon = " ";
        discharging_icon = " ";
        template = "| {{ if not .Error }}{{ .Icon }}{{ .Percentage }}{{ end }}";
      };
    };
    time = {
      type = "time";
      foreground = "lightGreen";
      style = "plain";
      properties = {
        template = "| {{ .CurrentDate | date .Format }} ";
      };
    };
    path = {
      background = "p:path_bg";
      foreground = "p:path_fg";
      powerline_symbol = "";
      type = "path";
      style = "powerline";
      properties = {
        home_icon = "~";
        style = "agnoster_full";
        template = " {{ .Path }} ";
      };
    };
    status = {
      alignment = "left";
      type = "status";
      style = "diamond";
      foreground = "#ffffff";
      background = "#00897b";
      background_templates = [ "{{ if .Error }}#e91e63{{ end }}" ];
      trailing_diamond = "";
      template = "<#193549></>  ";
      properties = {
        always_enabled = true;
      };
    };
  };
}
