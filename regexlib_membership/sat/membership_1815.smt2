;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ("[^"]*")|('[^\r]*)(\r\n)?
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\'\u00DF"
(define-fun Witness1 () String (seq.++ "'" (seq.++ "\xdf" "")))
;witness2: "\'"
(define-fun Witness2 () String (seq.++ "'" ""))

(assert (= regexA (re.union (re.++ (re.range "\x22" "\x22")(re.++ (re.* (re.union (re.range "\x00" "!") (re.range "#" "\xff"))) (re.range "\x22" "\x22"))) (re.++ (re.++ (re.range "'" "'") (re.* (re.union (re.range "\x00" "\x0c") (re.range "\x0e" "\xff")))) (re.opt (str.to_re (seq.++ "\x0d" (seq.++ "\x0a" ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
