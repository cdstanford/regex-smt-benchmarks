;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = http://(www\.)?([^\.]+)\.com 
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "http://\u009F.com "
(define-fun Witness1 () String (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "\u{9f}" (str.++ "." (str.++ "c" (str.++ "o" (str.++ "m" (str.++ " " ""))))))))))))))
;witness2: "http://www.\u00FF{.com \u009Ae"
(define-fun Witness2 () String (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "." (str.++ "\u{ff}" (str.++ "{" (str.++ "." (str.++ "c" (str.++ "o" (str.++ "m" (str.++ " " (str.++ "\u{9a}" (str.++ "e" "")))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" ""))))))))(re.++ (re.opt (str.to_re (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "." ""))))))(re.++ (re.+ (re.union (re.range "\u{00}" "-") (re.range "/" "\u{ff}"))) (str.to_re (str.++ "." (str.++ "c" (str.++ "o" (str.++ "m" (str.++ " " "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
