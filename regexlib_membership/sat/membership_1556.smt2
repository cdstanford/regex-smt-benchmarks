;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = .*[Pp]en[Ii1][\$s].*
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u009DpenI$"
(define-fun Witness1 () String (seq.++ "\x9d" (seq.++ "p" (seq.++ "e" (seq.++ "n" (seq.++ "I" (seq.++ "$" "")))))))
;witness2: "\u00F4Penis"
(define-fun Witness2 () String (seq.++ "\xf4" (seq.++ "P" (seq.++ "e" (seq.++ "n" (seq.++ "i" (seq.++ "s" "")))))))

(assert (= regexA (re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.union (re.range "P" "P") (re.range "p" "p"))(re.++ (str.to_re (seq.++ "e" (seq.++ "n" "")))(re.++ (re.union (re.range "1" "1")(re.union (re.range "I" "I") (re.range "i" "i")))(re.++ (re.union (re.range "$" "$") (re.range "s" "s")) (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
