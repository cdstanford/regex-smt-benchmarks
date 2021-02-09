;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\"(?<word>[^\"]+|\"\")*\"|(?<word>[^,]*))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: ""
(define-fun Witness1 () String "")
;witness2: ""
(define-fun Witness2 () String "")

(assert (= regexA (re.union (re.++ (re.range "\x22" "\x22")(re.++ (re.* (re.union (re.+ (re.union (re.range "\x00" "!") (re.range "#" "\xff"))) (str.to_re (seq.++ "\x22" (seq.++ "\x22" ""))))) (re.range "\x22" "\x22"))) (re.* (re.union (re.range "\x00" "+") (re.range "-" "\xff"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
