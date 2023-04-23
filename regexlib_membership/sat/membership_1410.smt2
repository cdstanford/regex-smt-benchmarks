;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [a-zA-Z]{3,}://[a-zA-Z0-9\.]+/*[a-zA-Z0-9/\\%_.]*\?*[a-zA-Z0-9/\\%_.=&amp;]*
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "qxfzPeKZ://.i%I"
(define-fun Witness1 () String (str.++ "q" (str.++ "x" (str.++ "f" (str.++ "z" (str.++ "P" (str.++ "e" (str.++ "K" (str.++ "Z" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "." (str.++ "i" (str.++ "%" (str.++ "I" ""))))))))))))))))
;witness2: "IyYs://Q\u00F2"
(define-fun Witness2 () String (str.++ "I" (str.++ "y" (str.++ "Y" (str.++ "s" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "Q" (str.++ "\u{f2}" ""))))))))))

(assert (= regexA (re.++ (re.++ ((_ re.loop 3 3) (re.union (re.range "A" "Z") (re.range "a" "z"))) (re.* (re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (str.to_re (str.++ ":" (str.++ "/" (str.++ "/" ""))))(re.++ (re.+ (re.union (re.range "." ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.* (re.range "/" "/"))(re.++ (re.* (re.union (re.range "%" "%")(re.union (re.range "." "9")(re.union (re.range "A" "Z")(re.union (re.range "\u{5c}" "\u{5c}")(re.union (re.range "_" "_") (re.range "a" "z")))))))(re.++ (re.* (re.range "?" "?")) (re.* (re.union (re.range "%" "&")(re.union (re.range "." "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "A" "Z")(re.union (re.range "\u{5c}" "\u{5c}")(re.union (re.range "_" "_") (re.range "a" "z")))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
