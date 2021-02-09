;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-zA-Z0-9&#192;&#193;&#194;&#195;&#196;&#197;&#198;&#199;&#200;&#201;&#202;&#203;&#204;&#205;&#206;&#207;&#208;&#209;&#210;&#211;&#212;&#213;&#214;&#216;&#217;&#218;&#219;&#220;&#221;&#223;&#224;&#225;&#226;&#227;&#228;&#229;&#230;&#231;&#232;&#233;&#234;&#235;&#236;&#237;&#238;&#239;&#241;&#242;&#243;&#244;&#245;&#246;&#248;&#249;&#250;&#251;&#252;&#253;&#255;\.\,\-\/\']+[a-zA-Z0-9&#192;&#193;&#194;&#195;&#196;&#197;&#198;&#199;&#200;&#201;&#202;&#203;&#204;&#205;&#206;&#207;&#208;&#209;&#210;&#211;&#212;&#213;&#214;&#216;&#217;&#218;&#219;&#220;&#221;&#223;&#224;&#225;&#226;&#227;&#228;&#229;&#230;&#231;&#232;&#233;&#234;&#235;&#236;&#237;&#238;&#239;&#241;&#242;&#243;&#244;&#245;&#246;&#248;&#249;&#250;&#251;&#252;&#253;&#255;\.\,\-\/\' ]+$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "1 "
(define-fun Witness1 () String (seq.++ "1" (seq.++ " " "")))
;witness2: "lWT1#Q"
(define-fun Witness2 () String (seq.++ "l" (seq.++ "W" (seq.++ "T" (seq.++ "1" (seq.++ "#" (seq.++ "Q" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "#" "#")(re.union (re.range "&" "'")(re.union (re.range "," "9")(re.union (re.range ";" ";")(re.union (re.range "A" "Z") (re.range "a" "z")))))))(re.++ (re.+ (re.union (re.range " " " ")(re.union (re.range "#" "#")(re.union (re.range "&" "'")(re.union (re.range "," "9")(re.union (re.range ";" ";")(re.union (re.range "A" "Z") (re.range "a" "z")))))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
