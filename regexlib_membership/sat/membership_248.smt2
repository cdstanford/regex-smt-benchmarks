;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \\[\\w{2}\\]
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\2\u00A5j$"
(define-fun Witness1 () String (seq.++ "\x5c" (seq.++ "2" (seq.++ "\xa5" (seq.++ "j" (seq.++ "$" ""))))))
;witness2: "\u00A4 \w\'\x1D\u008C\x11"
(define-fun Witness2 () String (seq.++ "\xa4" (seq.++ " " (seq.++ "\x5c" (seq.++ "w" (seq.++ "'" (seq.++ "\x1d" (seq.++ "\x8c" (seq.++ "\x11" "")))))))))

(assert (= regexA (re.++ (re.range "\x5c" "\x5c") (re.union (re.range "2" "2")(re.union (re.range "\x5c" "\x5c")(re.union (re.range "w" "w")(re.union (re.range "{" "{") (re.range "}" "}"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
