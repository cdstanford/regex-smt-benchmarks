;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([A-Z]|[a-z])|\/|\?|\-|\+|\=|\&|\%|\$|\#|\@|\!|\||\\|\}|\]|\[|\{|\;|\:|\'|\"|\,|\.|\>|\<|\*|([0-9])|\(|\)|\s
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\x138*"
(define-fun Witness1 () String (str.++ "\u{13}" (str.++ "8" (str.++ "*" ""))))
;witness2: "\u00AC!@"
(define-fun Witness2 () String (str.++ "\u{ac}" (str.++ "!" (str.++ "@" ""))))

(assert (= regexA (re.union (re.union (re.range "A" "Z") (re.range "a" "z"))(re.union (re.union (re.range "!" "'")(re.union (re.range "*" "/")(re.union (re.range ":" "@")(re.union (re.range "[" "]") (re.range "{" "}")))))(re.union (re.range "0" "9") (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "(" ")")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
