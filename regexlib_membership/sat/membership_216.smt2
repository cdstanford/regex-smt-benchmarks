;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = @([_a-zA-Z]+)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "6@R"
(define-fun Witness1 () String (seq.++ "6" (seq.++ "@" (seq.++ "R" ""))))
;witness2: "YA\u0091@up"
(define-fun Witness2 () String (seq.++ "Y" (seq.++ "A" (seq.++ "\x91" (seq.++ "@" (seq.++ "u" (seq.++ "p" "")))))))

(assert (= regexA (re.++ (re.range "@" "@") (re.+ (re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
