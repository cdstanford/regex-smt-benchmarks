;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = http://[^/]*/
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00EE\u00A7http:///"
(define-fun Witness1 () String (str.++ "\u{ee}" (str.++ "\u{a7}" (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "/" "")))))))))))
;witness2: "\u00D2\u00B9http://\u00C0>/"
(define-fun Witness2 () String (str.++ "\u{d2}" (str.++ "\u{b9}" (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "\u{c0}" (str.++ ">" (str.++ "/" "")))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" ""))))))))(re.++ (re.* (re.union (re.range "\u{00}" ".") (re.range "0" "\u{ff}"))) (re.range "/" "/")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
