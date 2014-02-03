# vim:se ft=zsh:
# ���Ϥ��䴰��ͭ���ˤ���
autoload -Uz compinit
compinit

# �ҥ��ȥ������
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

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

# disable <C-S><C-Q>
stty -ixon -ixoff
# disable <C-Z>
stty susp undef
