;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-zA-Z][a-zA-Z\&amp;amp;\-\.\'\s]*|)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "X\u00A0\u00A0\u0085"
(define-fun Witness1 () String (seq.++ "X" (seq.++ "\xa0" (seq.++ "\xa0" (seq.++ "\x85" "")))))
;witness2: ""
(define-fun Witness2 () String "")

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "&" "'")(re.union (re.range "-" ".")(re.union (re.range ";" ";")(re.union (re.range "A" "Z")(re.union (re.range "a" "z")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))))))) (str.to_re "")) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
