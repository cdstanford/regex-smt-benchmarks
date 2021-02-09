;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (antifraud\.ref\.num)[0-9]*(@citibank\.com)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00DD\u0090antifraud.ref.num84@citibank.comG"
(define-fun Witness1 () String (seq.++ "\xdd" (seq.++ "\x90" (seq.++ "a" (seq.++ "n" (seq.++ "t" (seq.++ "i" (seq.++ "f" (seq.++ "r" (seq.++ "a" (seq.++ "u" (seq.++ "d" (seq.++ "." (seq.++ "r" (seq.++ "e" (seq.++ "f" (seq.++ "." (seq.++ "n" (seq.++ "u" (seq.++ "m" (seq.++ "8" (seq.++ "4" (seq.++ "@" (seq.++ "c" (seq.++ "i" (seq.++ "t" (seq.++ "i" (seq.++ "b" (seq.++ "a" (seq.++ "n" (seq.++ "k" (seq.++ "." (seq.++ "c" (seq.++ "o" (seq.++ "m" (seq.++ "G" ""))))))))))))))))))))))))))))))))))))
;witness2: "\u00A3Tantifraud.ref.num69@citibank.com"
(define-fun Witness2 () String (seq.++ "\xa3" (seq.++ "T" (seq.++ "a" (seq.++ "n" (seq.++ "t" (seq.++ "i" (seq.++ "f" (seq.++ "r" (seq.++ "a" (seq.++ "u" (seq.++ "d" (seq.++ "." (seq.++ "r" (seq.++ "e" (seq.++ "f" (seq.++ "." (seq.++ "n" (seq.++ "u" (seq.++ "m" (seq.++ "6" (seq.++ "9" (seq.++ "@" (seq.++ "c" (seq.++ "i" (seq.++ "t" (seq.++ "i" (seq.++ "b" (seq.++ "a" (seq.++ "n" (seq.++ "k" (seq.++ "." (seq.++ "c" (seq.++ "o" (seq.++ "m" "")))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "a" (seq.++ "n" (seq.++ "t" (seq.++ "i" (seq.++ "f" (seq.++ "r" (seq.++ "a" (seq.++ "u" (seq.++ "d" (seq.++ "." (seq.++ "r" (seq.++ "e" (seq.++ "f" (seq.++ "." (seq.++ "n" (seq.++ "u" (seq.++ "m" ""))))))))))))))))))(re.++ (re.* (re.range "0" "9")) (str.to_re (seq.++ "@" (seq.++ "c" (seq.++ "i" (seq.++ "t" (seq.++ "i" (seq.++ "b" (seq.++ "a" (seq.++ "n" (seq.++ "k" (seq.++ "." (seq.++ "c" (seq.++ "o" (seq.++ "m" ""))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
