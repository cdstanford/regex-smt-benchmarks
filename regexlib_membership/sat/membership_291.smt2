;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([A-Z]|[a-z])|\/|\?|\-|\+|\=|\&|\%|\$|\#|\@|\!|\||\\|\}|\]|\[|\{|\;|\:|\'|\"|\,|\.|\>|\<|\*|([0-9])|\(|\)|\s
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\x138*"
(define-fun Witness1 () String (seq.++ "\x13" (seq.++ "8" (seq.++ "*" ""))))
;witness2: "\u00AC!@"
(define-fun Witness2 () String (seq.++ "\xac" (seq.++ "!" (seq.++ "@" ""))))

(assert (= regexA (re.union (re.union (re.range "A" "Z") (re.range "a" "z"))(re.union (re.union (re.range "!" "'")(re.union (re.range "*" "/")(re.union (re.range ":" "@")(re.union (re.range "[" "]") (re.range "{" "}")))))(re.union (re.range "0" "9") (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "(" ")")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
