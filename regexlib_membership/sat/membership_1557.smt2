;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = .*[Pp]re[Ss\$]cr[iI1]pt.*
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u008F0\x1B\x1Aprescr1pt\u00F5"
(define-fun Witness1 () String (seq.++ "\x8f" (seq.++ "0" (seq.++ "\x1b" (seq.++ "\x1a" (seq.++ "p" (seq.++ "r" (seq.++ "e" (seq.++ "s" (seq.++ "c" (seq.++ "r" (seq.++ "1" (seq.++ "p" (seq.++ "t" (seq.++ "\xf5" "")))))))))))))))
;witness2: "Pre$cript"
(define-fun Witness2 () String (seq.++ "P" (seq.++ "r" (seq.++ "e" (seq.++ "$" (seq.++ "c" (seq.++ "r" (seq.++ "i" (seq.++ "p" (seq.++ "t" ""))))))))))

(assert (= regexA (re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.union (re.range "P" "P") (re.range "p" "p"))(re.++ (str.to_re (seq.++ "r" (seq.++ "e" "")))(re.++ (re.union (re.range "$" "$")(re.union (re.range "S" "S") (re.range "s" "s")))(re.++ (str.to_re (seq.++ "c" (seq.++ "r" "")))(re.++ (re.union (re.range "1" "1")(re.union (re.range "I" "I") (re.range "i" "i")))(re.++ (str.to_re (seq.++ "p" (seq.++ "t" ""))) (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
