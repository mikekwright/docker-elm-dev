FROM mikewright/nodejs-dev:latest

# Install the common elm utilities
RUN npm install -g elm elm-test elm-oracle 

# Install elm-format (alpha right now)
RUN curl -sSL https://github.com/avh4/elm-format/releases/download/0.2.0-alpha/elm-format-0.2.0-alpha-linux-x64.tgz -o /elm-format.tgz && \
    cd / && tar -xzf elm-format.tgz && \
    mv elm-format /usr/bin && \
    rm elm-format.tgz

# Set environment to use UTF-8
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
RUN locale-gen en_US.UTF-8 && \
    dpkg-reconfigure locales

# Update vim plugins
ADD vimrc.bundles.local /root/.vimrc.bundles.local
RUN /update-vim

# Enable the vim format options 
RUN echo "let g:elm_format_autosave = 1\n" >> ~/.vimrc.before.local && \
    echo "let g:syntastic_always_populate_loc_list = 1\n" >> ~/.vimrc.before.local && \
    echo "let g:syntastic_auto_loc_list = 1\n" >> ~/.vimrc.before.local && \
    echo "let g:elm_syntastic_show_warnings = 1\n" >> ~/.vimrc.before.local && \
    echo "let g:elm_jump_to_error = 0\n" >> ~/.vimrc.before.local && \
    echo "let g:elm_make_output_file = \"elm.js\"\n" >> ~/.vimrc.before.local && \
    echo "let g:elm_make_show_warnings = 0\n" >> ~/.vimrc.before.local && \
    echo "let g:elm_syntastic_show_warnings = 0\n" >> ~/.vimrc.before.local && \
    echo "let g:elm_browser_command = \"\"\n" >> ~/.vimrc.before.local && \
    echo "let g:elm_detailed_complete = 0\n" >> ~/.vimrc.before.local && \
    echo "let g:elm_format_autosave = 0\n" >> ~/.vimrc.before.local && \
    echo "let g:elm_setup_keybindings = 1\n" >> ~/.vimrc.before.local && \
    echo "let g:elm_classic_hightlighting = 0\n" >> ~/.vimrc.before.local

# Expose the default port that reactor uses
EXPOSE 8000


