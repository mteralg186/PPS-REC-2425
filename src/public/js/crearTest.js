let questionCounter = 0;
    let questions = [];

    function showNotification(message, type = 'success') {
        const notification = document.getElementById('notificationContainer');
        notification.textContent = message;
        notification.className = `alert alert-${type}`;
        notification.classList.remove('d-none');

        setTimeout(() => {
            notification.classList.add('d-none');
        }, 5000);
    }

    function updateQuestionCount() {
        document.getElementById('questionCount').textContent = `${questionCounter}`;
    }

    function addQuestion() {
        if (questionCounter >= 20) {
            showNotification('Has alcanzado el límite máximo de 20 preguntas por test.', 'warning');
            return;
        }
        questionCounter++;
        const questionTitle = `${questionCounter}.`;
        const questionDiv = document.createElement('div');
        questionDiv.classList.add('question-container');
        showQuestionForm(questionDiv, questionTitle);
        document.getElementById('questionsContainer').appendChild(questionDiv);
        updateQuestionCount();
    }

    function showQuestionForm(questionDiv, questionTitle, questionData = null) {
        questionDiv.innerHTML = '';
        const form = document.createElement('div');

        const questionInput = document.createElement('input');
        questionInput.type = 'text';
        questionInput.placeholder = 'Escribe el nombre de la pregunta';
        questionInput.classList.add('form-control', 'mb-3');
        if (questionData) questionInput.value = questionData.question;
        form.appendChild(questionInput);

        const answersContainer = document.createElement('div');
        answersContainer.classList.add('answers-container');

        let correctAnswerIndex = questionData ? questionData.answers.indexOf(questionData.correctAnswer) : null;

        function addAnswer(answerText = '') {
            const answerContainer = document.createElement('div');
            answerContainer.classList.add('answer-container', 'd-flex', 'align-items-center', 'mb-2', 'gap-2');

            const answerInput = document.createElement('input');
            answerInput.type = 'text';
            answerInput.placeholder = 'Escribe una respuesta';
            answerInput.classList.add('form-control', 'answer-input');
            answerInput.value = answerText;

            const correctAnswerBtn = document.createElement('button');
            correctAnswerBtn.textContent = '✓';
            correctAnswerBtn.classList.add('btn', 'btn-outline-success', 'correct-answer');

            if (correctAnswerIndex !== null && answersContainer.children.length === correctAnswerIndex) {
                correctAnswerBtn.classList.add('btn-success');
                correctAnswerBtn.classList.remove('btn-outline-success');
            }

            correctAnswerBtn.addEventListener('click', function(event) {
                event.preventDefault();
                correctAnswerIndex = Array.from(answersContainer.children).indexOf(answerContainer);
                updateCorrectAnswerIndex();
            });

            const removeBtn = document.createElement('button');
            removeBtn.innerHTML = '&#10005;';
            removeBtn.classList.add('btn', 'btn-outline-danger', 'delete-answer');
            removeBtn.addEventListener('click', function(event) {
                event.preventDefault();
                const index = Array.from(answersContainer.children).indexOf(answerContainer);
                answersContainer.removeChild(answerContainer);
                if (correctAnswerIndex === index) {
                    correctAnswerIndex = null;
                } else if (correctAnswerIndex > index) {
                    correctAnswerIndex--;
                }
                updateCorrectAnswerIndex();
            });

            answerContainer.appendChild(answerInput);
            answerContainer.appendChild(correctAnswerBtn);
            answerContainer.appendChild(removeBtn);
            answersContainer.appendChild(answerContainer);
        }

        function updateCorrectAnswerIndex() {
            Array.from(answersContainer.children).forEach((child, index) => {
                const btn = child.querySelector('.correct-answer');
                btn.classList.toggle('btn-success', index === correctAnswerIndex);
                btn.classList.toggle('btn-outline-success', index !== correctAnswerIndex);
            });
        }

        const addAnswerBtn = document.createElement('button');
        addAnswerBtn.textContent = 'Añadir Respuesta';
        addAnswerBtn.classList.add('btn', 'btn-secondary', 'mb-2');
        addAnswerBtn.style.display = 'block';
        addAnswerBtn.addEventListener('click', function(event) {
            event.preventDefault();
            addAnswer();
        });

        const submitBtn = document.createElement('button');
        submitBtn.textContent = 'Aceptar Pregunta';
        submitBtn.classList.add('btn', 'btn-success', 'mb-2');
        submitBtn.style.display = 'block';
        submitBtn.addEventListener('click', function(event) {
            event.preventDefault();

            const questionName = questionInput.value.trim();
            const answers = Array.from(answersContainer.querySelectorAll('.answer-input'))
                .map(input => input.value.trim())
                .filter(v => v !== '');

            if (questionName && answers.length > 0 && correctAnswerIndex !== null) {
                const questionIndex = questions.findIndex(q => q.questionTitle === questionTitle);
                const questionData = {
                    questionTitle,
                    question: questionName,
                    answers,
                    correctAnswer: answers[correctAnswerIndex]
                };

                if (questionIndex > -1) {
                    questions[questionIndex] = questionData;
                } else {
                    questions.push(questionData);
                }

                renderQuestionSummary(questionDiv, questionData);
                updateQuestionCount();
            } else {
                showNotification('Por favor, completa el nombre de la pregunta, agrega respuestas y selecciona la respuesta correcta.', 'warning');
            }
        });

        form.appendChild(addAnswerBtn);
        form.appendChild(answersContainer);
        form.appendChild(submitBtn);
        questionDiv.appendChild(form);

        if (questionData?.answers?.length > 0) {
            questionData.answers.forEach(answer => addAnswer(answer));
        }

        questionInput.focus();
    }

    function renderQuestionSummary(questionDiv, questionData) {
        questionDiv.innerHTML = '';

        const questionNumber = document.createElement('h3');
        questionNumber.textContent = `${questionData.questionTitle} ${questionData.question}`;
        questionNumber.classList.add('question-title');
        questionDiv.appendChild(questionNumber);

        const removeButton = document.createElement('button');
        removeButton.innerHTML = '&#10005;';
        removeButton.classList.add('delete-question');
        removeButton.style.display = 'none';
        removeButton.addEventListener('click', function() {
            document.getElementById('questionsContainer').removeChild(questionDiv);
            questions = questions.filter(q => q.questionTitle !== questionData.questionTitle);
            updateQuestionNumbers();
        });
        questionDiv.appendChild(removeButton);

        const description = document.createElement('p');
        description.textContent = `${questionData.question} (${questionData.answers.length} opciones)`;
        questionDiv.appendChild(description);

        questionDiv.addEventListener('mouseover', () => removeButton.style.display = 'inline');
        questionDiv.addEventListener('mouseout', () => removeButton.style.display = 'none');

        questionNumber.addEventListener('click', () => showQuestionForm(questionDiv, questionData.questionTitle, questionData));
    }

    function updateQuestionNumbers() {
        const questionDivs = document.querySelectorAll('#questionsContainer > .question-container');
        questionCounter = 0;
        questionDivs.forEach((questionDiv, index) => {
            questionCounter++;
            const questionTitle = `${questionCounter}.`;
            const oldTitle = questionDiv.querySelector('.question-title').textContent;
            questionDiv.querySelector('.question-title').textContent = questionTitle;
            const i = questions.findIndex(q => q.questionTitle === oldTitle);
            if (i >= 0) questions[i].questionTitle = questionTitle;
        });
        updateQuestionCount();
    }

    document.getElementById('newQuestionBtn').addEventListener('click', addQuestion);

    document.getElementById('testForm').addEventListener('submit', function (event) {
        event.preventDefault();

        if (questions.length === 0) {
            showNotification('No has añadido preguntas para enviar. Por favor, agrega al menos una pregunta.', 'warning');
            return;
        }

        const nombreExamen = document.getElementById('nombreExamen').value.trim();
        const id_categoria = document.getElementById('id_categoria').value;
        const nueva_categoria = document.getElementById('nueva_categoria').value.trim();
        const id_clase = document.getElementById('id_clase').value;
        const fechaDisponible = document.getElementById('fechaDisponible').value;
        const fechaFin = document.getElementById('fechaFin').value;

        if (!nombreExamen || (!id_categoria && !nueva_categoria) || !id_clase || !fechaDisponible || !fechaFin) {
            showNotification('Por favor, completa todos los campos del examen, incluyendo fecha y hora de disponibilidad y finalización.', 'warning');
            return;
        }

        fetch('/enviaTest', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                nombreExamen,
                id_categoria: id_categoria ? parseInt(id_categoria) : null,
                nueva_categoria: nueva_categoria ? nueva_categoria : null,
                id_clase: parseInt(id_clase),
                fechaDisponible,
                fechaFin,
                questions
            })
        })
        .then(response => {
            if (response.ok) {
                showNotification('El examen se ha guardado correctamente.');
                questions = [];
                document.getElementById('questionsContainer').innerHTML = '';
                updateQuestionCount();
                document.getElementById('nombreExamen').value = '';
                document.getElementById('id_categoria').value = '';
                document.getElementById('nueva_categoria').value = '';
                document.getElementById('id_clase').value = '';
                document.getElementById('fechaDisponible').value = '';
                document.getElementById('fechaFin').value = '';
            } else {
                showNotification('Hubo un error al guardar el examen. Inténtalo de nuevo más tarde.', 'danger');
            }
        })
        .catch(() => showNotification('No se pudo conectar al servidor. Por favor, verifica tu conexión e inténtalo nuevamente.', 'danger'));
    });