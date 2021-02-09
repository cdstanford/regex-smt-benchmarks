;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\[[abiu][^\[\]]*\])([^\[\]]+)(\[/?[abiu]\])
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00B4>\xA[u]\u0093\u00EA[/b]\u00C0+\u008D"
(define-fun Witness1 () String (seq.++ "\xb4" (seq.++ ">" (seq.++ "\x0a" (seq.++ "[" (seq.++ "u" (seq.++ "]" (seq.++ "\x93" (seq.++ "\xea" (seq.++ "[" (seq.++ "/" (seq.++ "b" (seq.++ "]" (seq.++ "\xc0" (seq.++ "+" (seq.++ "\x8d" ""))))))))))))))))
;witness2: "[u\u00B1]2[u]\u009F"
(define-fun Witness2 () String (seq.++ "[" (seq.++ "u" (seq.++ "\xb1" (seq.++ "]" (seq.++ "2" (seq.++ "[" (seq.++ "u" (seq.++ "]" (seq.++ "\x9f" ""))))))))))

(assert (= regexA (re.++ (re.++ (re.range "[" "[")(re.++ (re.union (re.range "a" "b")(re.union (re.range "i" "i") (re.range "u" "u")))(re.++ (re.* (re.union (re.range "\x00" "Z")(re.union (re.range "\x5c" "\x5c") (re.range "^" "\xff")))) (re.range "]" "]"))))(re.++ (re.+ (re.union (re.range "\x00" "Z")(re.union (re.range "\x5c" "\x5c") (re.range "^" "\xff")))) (re.++ (re.range "[" "[")(re.++ (re.opt (re.range "/" "/"))(re.++ (re.union (re.range "a" "b")(re.union (re.range "i" "i") (re.range "u" "u"))) (re.range "]" "]"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
