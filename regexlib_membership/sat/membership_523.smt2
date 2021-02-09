;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?<title>.*\.\s)*(?<firstname>([A-Z][a-z]+\s*)+)(\s)(?<middleinitial>([A-Z]\.?\s)*)(?<lastname>[A-Z][a-zA-Z-']+)(?<suffix>.*)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: ".\u0085\u00ABg.\u00A0Ng X\xDG.\u00A0L\xCNNw\u00CF\xB"
(define-fun Witness1 () String (seq.++ "." (seq.++ "\x85" (seq.++ "\xab" (seq.++ "g" (seq.++ "." (seq.++ "\xa0" (seq.++ "N" (seq.++ "g" (seq.++ " " (seq.++ "X" (seq.++ "\x0d" (seq.++ "G" (seq.++ "." (seq.++ "\xa0" (seq.++ "L" (seq.++ "\x0c" (seq.++ "N" (seq.++ "N" (seq.++ "w" (seq.++ "\xcf" (seq.++ "\x0b" ""))))))))))))))))))))))
;witness2: "Yuit\u0085\u00A0Kph\u0085\u00A0Z.\u00A0V-z\'\u00B8"
(define-fun Witness2 () String (seq.++ "Y" (seq.++ "u" (seq.++ "i" (seq.++ "t" (seq.++ "\x85" (seq.++ "\xa0" (seq.++ "K" (seq.++ "p" (seq.++ "h" (seq.++ "\x85" (seq.++ "\xa0" (seq.++ "Z" (seq.++ "." (seq.++ "\xa0" (seq.++ "V" (seq.++ "-" (seq.++ "z" (seq.++ "'" (seq.++ "\xb8" ""))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.range "." ".") (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))(re.++ (re.+ (re.++ (re.range "A" "Z")(re.++ (re.+ (re.range "a" "z")) (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ (re.* (re.++ (re.range "A" "Z")(re.++ (re.opt (re.range "." ".")) (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))(re.++ (re.++ (re.range "A" "Z") (re.+ (re.union (re.range "'" "'")(re.union (re.range "-" "-")(re.union (re.range "A" "Z") (re.range "a" "z"))))))(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
