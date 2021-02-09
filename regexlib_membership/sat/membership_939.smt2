;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = http://[^/]*/
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00EE\u00A7http:///"
(define-fun Witness1 () String (seq.++ "\xee" (seq.++ "\xa7" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "/" "")))))))))))
;witness2: "\u00D2\u00B9http://\u00C0>/"
(define-fun Witness2 () String (seq.++ "\xd2" (seq.++ "\xb9" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "\xc0" (seq.++ ">" (seq.++ "/" "")))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" ""))))))))(re.++ (re.* (re.union (re.range "\x00" ".") (re.range "0" "\xff"))) (re.range "/" "/")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
