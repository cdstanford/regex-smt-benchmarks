;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([^\.\?\!]*)[\.\?\!]
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: ">.v\u00C8"
(define-fun Witness1 () String (seq.++ ">" (seq.++ "." (seq.++ "v" (seq.++ "\xc8" "")))))
;witness2: "?"
(define-fun Witness2 () String (seq.++ "?" ""))

(assert (= regexA (re.++ (re.* (re.union (re.range "\x00" " ")(re.union (re.range "\x22" "-")(re.union (re.range "/" ">") (re.range "@" "\xff"))))) (re.union (re.range "!" "!")(re.union (re.range "." ".") (re.range "?" "?"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
