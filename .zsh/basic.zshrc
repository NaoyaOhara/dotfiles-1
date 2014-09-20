# vim:se ft=zsh:
# ���Ϥ��䴰��ͭ���ˤ���
autoload -Uz compinit
compinit

# �ҥ��ȥ������
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt share_history

bindkey -v               # vi �������Х���ɤˤ���
bindkey "" history-incremental-search-backward # bash �� <C-R> �Ȱ��
# http://d.hatena.ne.jp/kei_q/20110308/1299594629
show_buffer_stack() {
  POSTDISPLAY="
stack: $LBUFFER"
  zle push-line
}
zle -N show_buffer_stack
bindkey "^[q" show_buffer_stack

export LANG=ja_JP.UTF-8
setopt print_eight_bit   # ���ܸ�ե�����̾��ɽ����ǽ�ˤ���
setopt no_flow_control   # �ե�����ȥ����̵���ˤ���
setopt transient_rprompt # �Ǹ�ʳ��α��ץ��ץȤ�ä�
setopt auto_cd           # �ǥ��쥯�ȥ�̾�����ǰ�ư����
setopt EXTENDED_GLOB     # ����� glob
setopt HIST_IGNORE_SPACE # �ǽ�˥��ڡ����Τ��륳�ޥ�ɤ�������ɲä��ʤ�
setopt inc_append_history hist_ignore_dups # ʣ���Υ����ߥʥ�� history ��ͭ����

# zsh-notify x Growl - ��������������Фä���������Ƥޤ�@�ϤƤ�
# http://moqada.hatenablog.com/entry/2014/03/26/121915
autoload -Uz add-zsh-hook

# for brewed zsh
unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/help

# �䴰����ʸ����ʸ������̤��ʤ�
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# disable <C-S><C-Q>
stty -ixon -ixoff
# disable <C-Z>
stty susp undef

# MacVim��zsh�δĶ��ѿ��ɤ߹��ޤ�����ˡ - ���󥸥˥��Ǥ��衪
# http://totem3.hatenablog.jp/entry/2013/10/17/055942
typeset -U name_of_the_variable
