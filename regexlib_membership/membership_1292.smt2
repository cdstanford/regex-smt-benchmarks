;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (antifraud\.ref\.num)[0-9]*(@citibank\.com)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00DD\u0090antifraud.ref.num84@citibank.comG"
(define-fun Witness1 () String (str.++ "\u{dd}" (str.++ "\u{90}" (str.++ "a" (str.++ "n" (str.++ "t" (str.++ "i" (str.++ "f" (str.++ "r" (str.++ "a" (str.++ "u" (str.++ "d" (str.++ "." (str.++ "r" (str.++ "e" (str.++ "f" (str.++ "." (str.++ "n" (str.++ "u" (str.++ "m" (str.++ "8" (str.++ "4" (str.++ "@" (str.++ "c" (str.++ "i" (str.++ "t" (str.++ "i" (str.++ "b" (str.++ "a" (str.++ "n" (str.++ "k" (str.++ "." (str.++ "c" (str.++ "o" (str.++ "m" (str.++ "G" ""))))))))))))))))))))))))))))))))))))
;witness2: "\u00A3Tantifraud.ref.num69@citibank.com"
(define-fun Witness2 () String (str.++ "\u{a3}" (str.++ "T" (str.++ "a" (str.++ "n" (str.++ "t" (str.++ "i" (str.++ "f" (str.++ "r" (str.++ "a" (str.++ "u" (str.++ "d" (str.++ "." (str.++ "r" (str.++ "e" (str.++ "f" (str.++ "." (str.++ "n" (str.++ "u" (str.++ "m" (str.++ "6" (str.++ "9" (str.++ "@" (str.++ "c" (str.++ "i" (str.++ "t" (str.++ "i" (str.++ "b" (str.++ "a" (str.++ "n" (str.++ "k" (str.++ "." (str.++ "c" (str.++ "o" (str.++ "m" "")))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "a" (str.++ "n" (str.++ "t" (str.++ "i" (str.++ "f" (str.++ "r" (str.++ "a" (str.++ "u" (str.++ "d" (str.++ "." (str.++ "r" (str.++ "e" (str.++ "f" (str.++ "." (str.++ "n" (str.++ "u" (str.++ "m" ""))))))))))))))))))(re.++ (re.* (re.range "0" "9")) (str.to_re (str.++ "@" (str.++ "c" (str.++ "i" (str.++ "t" (str.++ "i" (str.++ "b" (str.++ "a" (str.++ "n" (str.++ "k" (str.++ "." (str.++ "c" (str.++ "o" (str.++ "m" ""))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
