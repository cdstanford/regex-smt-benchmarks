;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((http|ftp|https):\/\/w{3}[\d]*.|(http|ftp|https):\/\/|w{3}[\d]*.)([\w\d\._\-#\(\)\[\]\\,;:]+@[\w\d\._\-#\(\)\[\]\\,;:])?([a-z0-9]+.)*[a-z\-0-9]+.([a-z]{2,3})?[a-z]{2,6}(:[0-9]+)?(\/[\/a-z0-9\._\-,]+)*[a-z0-9\-_\.\s\%]+(\?[a-z0-9=%&amp;\.\-,#]+)?
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "https://www4\u0094\u00B5s@\u00CE63grg9%9-\u00ABmayo:1/i8"
(define-fun Witness1 () String (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "4" (seq.++ "\x94" (seq.++ "\xb5" (seq.++ "s" (seq.++ "@" (seq.++ "\xce" (seq.++ "6" (seq.++ "3" (seq.++ "g" (seq.++ "r" (seq.++ "g" (seq.++ "9" (seq.++ "%" (seq.++ "9" (seq.++ "-" (seq.++ "\xab" (seq.++ "m" (seq.++ "a" (seq.++ "y" (seq.++ "o" (seq.++ ":" (seq.++ "1" (seq.++ "/" (seq.++ "i" (seq.++ "8" "")))))))))))))))))))))))))))))))))))))
;witness2: "wwwx\u00C6@Fj\u00E0txppjr:82\u00A05\u0085\u00A0%\u0085?r\u00C8\u00A9\u00E2\u00B8"
(define-fun Witness2 () String (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "x" (seq.++ "\xc6" (seq.++ "@" (seq.++ "F" (seq.++ "j" (seq.++ "\xe0" (seq.++ "t" (seq.++ "x" (seq.++ "p" (seq.++ "p" (seq.++ "j" (seq.++ "r" (seq.++ ":" (seq.++ "8" (seq.++ "2" (seq.++ "\xa0" (seq.++ "5" (seq.++ "\x85" (seq.++ "\xa0" (seq.++ "%" (seq.++ "\x85" (seq.++ "?" (seq.++ "r" (seq.++ "\xc8" (seq.++ "\xa9" (seq.++ "\xe2" (seq.++ "\xb8" "")))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (re.union (re.++ (re.union (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" "")))))(re.union (str.to_re (seq.++ "f" (seq.++ "t" (seq.++ "p" "")))) (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ "s" ""))))))))(re.++ (str.to_re (seq.++ ":" (seq.++ "/" (seq.++ "/" ""))))(re.++ ((_ re.loop 3 3) (re.range "w" "w"))(re.++ (re.* (re.range "0" "9")) (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))))(re.union (re.++ (re.union (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" "")))))(re.union (str.to_re (seq.++ "f" (seq.++ "t" (seq.++ "p" "")))) (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ "s" "")))))))) (str.to_re (seq.++ ":" (seq.++ "/" (seq.++ "/" ""))))) (re.++ ((_ re.loop 3 3) (re.range "w" "w"))(re.++ (re.* (re.range "0" "9")) (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))))(re.++ (re.opt (re.++ (re.+ (re.union (re.range "#" "#")(re.union (re.range "(" ")")(re.union (re.range "," ".")(re.union (re.range "0" ";")(re.union (re.range "A" "]")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))))(re.++ (re.range "@" "@") (re.union (re.range "#" "#")(re.union (re.range "(" ")")(re.union (re.range "," ".")(re.union (re.range "0" ";")(re.union (re.range "A" "]")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))))))(re.++ (re.* (re.++ (re.+ (re.union (re.range "0" "9") (re.range "a" "z"))) (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z"))))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ (re.opt ((_ re.loop 2 3) (re.range "a" "z")))(re.++ ((_ re.loop 2 6) (re.range "a" "z"))(re.++ (re.opt (re.++ (re.range ":" ":") (re.+ (re.range "0" "9"))))(re.++ (re.* (re.++ (re.range "/" "/") (re.+ (re.union (re.range "," "9")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "%" "%")(re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))))) (re.opt (re.++ (re.range "?" "?") (re.+ (re.union (re.range "#" "#")(re.union (re.range "%" "&")(re.union (re.range "," ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=") (re.range "a" "z"))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
