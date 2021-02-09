;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = http://(www\.)?([^\.]+)\.com 
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "http://\u009F.com "
(define-fun Witness1 () String (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "\x9f" (seq.++ "." (seq.++ "c" (seq.++ "o" (seq.++ "m" (seq.++ " " ""))))))))))))))
;witness2: "http://www.\u00FF{.com \u009Ae"
(define-fun Witness2 () String (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "." (seq.++ "\xff" (seq.++ "{" (seq.++ "." (seq.++ "c" (seq.++ "o" (seq.++ "m" (seq.++ " " (seq.++ "\x9a" (seq.++ "e" "")))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" ""))))))))(re.++ (re.opt (str.to_re (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "." ""))))))(re.++ (re.+ (re.union (re.range "\x00" "-") (re.range "/" "\xff"))) (str.to_re (seq.++ "." (seq.++ "c" (seq.++ "o" (seq.++ "m" (seq.++ " " "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
